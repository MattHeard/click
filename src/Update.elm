module Update exposing (Model, Msg(..), updateModelAndUpdateCache)


type alias Model =
    FundsAmount


type alias FundsAmount =
    Int


type Msg
    = Increment


updateModelAndUpdateCache : (Model -> Cmd Msg) -> Msg -> Model -> ( Model, Cmd Msg )
updateModelAndUpdateCache save msg model =
    case msg of
        Increment ->
            let
                newModel =
                    model + 1
            in
            ( newModel
            , save newModel
            )
