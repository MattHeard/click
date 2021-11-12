module Update exposing (Model, Msg(..), updateModelAndUpdateCache)


type alias Model =
    FundsAmount


type alias FundsAmount =
    Int


type Msg
    = Increment


updateModelAndUpdateCache : (Model -> Cmd msg) -> Msg -> Model -> ( Model, Cmd msg )
updateModelAndUpdateCache save msg model =
    updateModel msg model |> getTupleWithSave save


updateModel : Msg -> Model -> Model
updateModel msg model =
    case msg of
        Increment ->
            let
                newModel =
                    model + 1
            in
            newModel


getTupleWithSave : (Model -> Cmd msg) -> Model -> ( Model, Cmd msg )
getTupleWithSave save model =
    ( model, save model )
