module Main exposing (main)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)
import Json.Encode as Encode exposing (encode, int)

import Ports

main : Program () Model Msg
main =
  Browser.element
    { init = \flags -> init
    , update = update
    , view = view
    , subscriptions = \_ -> Sub.none
    }

type Msg = Increment
type alias Model = Int

init : ( Model, Cmd msg )
init =
  ( 0, Cmd.none )

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
  encode 0 (int model)
    |> Ports.storeModel
