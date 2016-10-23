module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.App as App
import Http
import Task
import Json.Decode exposing (..)


-- model


type alias Model =
    String


initModel : Model
initModel =
    "Finding a joke..."


init : ( Model, Cmd Msg )
init =
    ( initModel, randomJoke )


type alias Response =
    { id : Int
    , joke : String
    , categories : List String
    }


responseDecoder : Decoder Response
responseDecoder =
    object3 Response
        ("id" := int)
        ("joke" := string)
        ("categories" := list string)
        |> at [ "value" ]


randomJoke : Cmd Msg
randomJoke =
    let
        url =
            "http://api.icndb.com/jokes/random"

        task =
            Http.get responseDecoder url

        cmd =
            Task.perform Fail Joke task
    in
        cmd



-- update


type Msg
    = Joke Response
    | Fail Http.Error
    | GetNewJoke


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Joke response ->
            ( toString (response.id) ++ " " ++ response.joke, Cmd.none )

        Fail error ->
            ( (toString error), Cmd.none )

        GetNewJoke ->
            ( initModel, randomJoke )



-- view


view : Model -> Html Msg
view model =
    div []
        [ p []
            [ text model ]
        , hr [] []
        , button
            [ onClick GetNewJoke ]
            [ text "Another?" ]
        ]



-- subscription


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


main : Program Never
main =
    App.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
