module UpdateTest exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)
import Update exposing (Msg(..), updateModelAndUpdateCache)


suite : Test
suite =
    describe "the Increment message"
        [ test "adds one to the model" <|
            \_ ->
                Expect.equal
                    (updateModelAndUpdateCache
                        (\arg -> Cmd.none)
                        Increment
                        0)
                    ( 1, Cmd.none )
        ]
