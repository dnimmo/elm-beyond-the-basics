module Login exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


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


update : Msg -> Model -> Model
update msg model =
    case msg of
        UsernameInput username ->
            { model | username = username }

        PasswordInput password ->
            { model | password = password }



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
                [ type' "submit" ]
                [ text "Login" ]
            ]
        ]
