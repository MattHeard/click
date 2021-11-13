module Update exposing (Model, Msg(..), updateModel)


type alias Model =
    { fundsAmount : FundsAmount
    , incrementAmount : IncrementAmount
    }


type alias FundsAmount =
    Int


type alias IncrementAmount =
    Int


type Msg
    = Increment


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Increment ->
            let
                newModel =
                    { fundsAmount = model.fundsAmount + 1
                    , incrementAmount = 1
                    }
            in
            newModel
