module Example exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Test exposing (..)


suite : Test
suite =
    describe "Hello world"
        [ test "1+1=2" <|
            \_ ->
                Expect.equal (1 + 1) 2
        ]
