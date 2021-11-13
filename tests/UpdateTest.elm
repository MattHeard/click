module UpdateTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Update exposing (Model, Msg(..), updateModel)


suite : Test
suite =
    describe "the Increment message"
        [ test "adds one to the model" <|
            \_ ->
                Expect.equal
                    (updateModel
                        Increment
                        (buildTestModel 0)
                    )
                    (buildTestModel 1)
        ]

buildTestModel : Int -> Model
buildTestModel fundsAmount =
    { fundsAmount = fundsAmount
    , incrementAmount = 1
    }
