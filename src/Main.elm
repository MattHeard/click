module Main exposing (main)

import Browser
import Html exposing (Html, button, div, li, text, ul)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (decodeString)
import Json.Encode as Encode exposing (encode)
import Ports


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


type Msg
    = Increment


type alias Model =
    FundsAmount


type alias FundsAmount =
    Int


init : Maybe String -> ( Model, Cmd msg )
init flags =
    let
        model =
            case flags of
                Just modelJson ->
                    decodeStoredModel modelJson

                Nothing ->
                    0
    in
    ( model, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    updateAndSave saveModel msg model


updateAndSave : (FundsAmount -> Cmd Msg) -> Msg -> Model -> ( Model, Cmd Msg )
updateAndSave save msg model =
    case msg of
        Increment ->
            let
                newModel =
                    model + 1
            in
            ( newModel
            , save newModel
            )


view : Model -> Html Msg
view model =
    model
        |> contents
        |> List.map List.singleton
        |> List.map (li [])
        |> ul []


contents : Model -> List (Html Msg)
contents model =
    [ renderFunds model
    , renderFundsIncrement 1
    , renderIncrementButton
    , renderVersion
    ]


renderFunds : Model -> Html Msg
renderFunds model =
    model |> String.fromInt |> text


renderFundsIncrement : Model -> Html Msg
renderFundsIncrement model =
    model |> String.fromInt |> text


renderIncrementButton : Html Msg
renderIncrementButton =
    button [ onClick Increment ] [ text "+" ]


renderVersion : Html Msg
renderVersion =
    text "6"


saveModel : FundsAmount -> Cmd msg
saveModel model =
    encode 0 (Encode.int model)
        |> Ports.storeModel


decodeStoredModel : String -> Model
decodeStoredModel modelJson =
    case decodeString Decode.int modelJson of
        Ok model ->
            model

        Err _ ->
            0
