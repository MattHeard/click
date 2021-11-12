module UpdateTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Update exposing (Msg(..), updateModel)


suite : Test
suite =
    describe "the Increment message"
        [ test "adds one to the model" <|
            \_ ->
                Expect.equal
                    (updateModel
                        Increment
                        { fundsAmount = 0 }
                    )
                    { fundsAmount = 1 }
        ]
