module Login exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import Html.App as App


-- model


type alias Model =
    { username : String
    , password : String
    }


initModel : Model
initModel =
    { username = ""
    , password = ""
    }



-- update


type Msg
    = UsernameInput String
    | PasswordInput String
    | Login


update : Msg -> Model -> Model
update msg model =
    case msg of
        UsernameInput username ->
            { model | username = username }

        PasswordInput password ->
            { model | password = password }

        Login ->
            initModel



-- view


view : Model -> Html Msg
view model =
    div []
        [ h3 [] [ text "Login" ]
        , Html.form []
            [ input
                [ type' "text"
                , placeholder "Enter username"
                , onInput UsernameInput
                ]
                []
            , input
                [ type' "password"
                , placeholder "Enter password"
                , onInput PasswordInput
                ]
                []
            , button
                [ type' "submit"
                , onSubmit Login
                ]
                [ text "Login" ]
            ]
        ]


main : Program Never
main =
    App.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
