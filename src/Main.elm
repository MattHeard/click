module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Decode as Decode exposing (decodeString)
import Json.Encode as Encode exposing (encode)

import Ports

type alias RetrievedState = Maybe String

main : Program RetrievedState Model Msg
main =
  Browser.element
    { init = init
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }

type Msg = Increment
type alias Model = Int

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
  case msg of
    Increment ->
      let
        newModel = model + 1
      in
      ( newModel 
      , saveModel newModel 
      )

view : Model -> Html Msg
view model =
  div []
    [ div [] [ text (String.fromInt model) ]
    , button [ onClick Increment ] [ text "+" ]
    ]

saveModel : Int -> Cmd msg
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
