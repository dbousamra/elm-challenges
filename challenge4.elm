module Challenge4 exposing (..)

import Bulma.CDN exposing (stylesheet)
import Bulma.Elements exposing (TitleSize(..), title)
import Bulma.Form exposing (..)
import Bulma.Layout exposing (..)
import Bulma.Modifiers exposing (..)
import Html exposing (..)
import Html.Attributes exposing (placeholder)
import Html.Events exposing (onInput)
import Time exposing (Time, second)


type alias Model =
    { username : String
    , lastKeyPress : Maybe Time
    }


type Msg
    = NoOp
    | UpdateQuery String


init : ( Model, Cmd Msg )
init =
    ( { username = "DOM", lastKeyPress = Nothing }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case Debug.log "update" msg of
        NoOp ->
            ( model, Cmd.none )

        UpdateQuery name ->
            ( { model | username = name, lastKeyPress = Nothing }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


usernameInput : Html Msg
usernameInput =
    let
        myControlAttrs =
            []

        myInputAttrs =
            [ onInput UpdateQuery
            , placeholder "Name"
            ]
    in
    controlInput controlInputModifiers
        myControlAttrs
        myInputAttrs
        []


view : Model -> Html Msg
view model =
    main_ []
        [ stylesheet
        , container []
            [ title H1 [] [ text "Hero Title" ]
            , usernameInput
            ]
        ]


main : Program Never Model Msg
main =
    program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
