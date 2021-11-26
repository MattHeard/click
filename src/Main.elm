module Main exposing (main)

import Browser
import Html exposing (Html, button, div, li, span, text, ul)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (decodeString)
import Json.Encode as Encode exposing (encode)
import Ports
import Update exposing (Model, Msg(..), updateModel)


type alias RetrievedState =
    Maybe String


main : Program RetrievedState Model Msg
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = \_ -> Sub.none
        }


init : Maybe String -> ( Model, Cmd msg )
init flags =
    let
        model =
            case flags of
                Just modelJson ->
                    decodeStoredModel modelJson

                Nothing ->
                    { fundsAmount = 0
                    , incrementAmount = 1
                    }
    in
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updateModelAndUpdateCache saveModel msg model


updateModelAndUpdateCache : (Model -> Cmd msg) -> Msg -> Model -> ( Model, Cmd msg )
updateModelAndUpdateCache save msg model =
    updateModel msg model |> getTupleWithSave save


getTupleWithSave : (Model -> Cmd msg) -> Model -> ( Model, Cmd msg )
getTupleWithSave save model =
    ( model, save model )


view : Model -> Html Msg
view model =
    model
        |> contents
        |> List.map List.singleton
        |> List.map (li [])
        |> ul []


contents : Model -> List (Html Msg)
contents model =
    [ text "Click"
    , renderFunds model.fundsAmount
    , renderFundsIncrement model.incrementAmount
    , renderIncrementButton
    , renderVersion "v18"
    ]


renderFunds : Int -> Html Msg
renderFunds amount =
    span
        []
        [ text "$ "
        , renderNumber amount
        ]


renderFundsIncrement : Int -> Html Msg
renderFundsIncrement amount =
    span
        []
        [ text "$ "
        , renderNumber amount
        , text " / click of A"
        ]


renderNumber : Int -> Html Msg
renderNumber n =
    n |> String.fromInt |> text


renderIncrementButton : Html Msg
renderIncrementButton =
    button [ onClick Increment ] [ text "A" ]


renderVersion : String -> Html Msg
renderVersion version =
    text version


saveModel : Model -> Cmd msg
saveModel model =
    encode 0 (Encode.int model.fundsAmount)
        |> Ports.storeModel


decodeStoredModel : String -> Model
decodeStoredModel modelJson =
    case decodeString Decode.int modelJson of
        Ok model ->
            { fundsAmount = model
            , incrementAmount = 1
            }

        Err _ ->
            { fundsAmount = 0
            , incrementAmount = 1
            }
