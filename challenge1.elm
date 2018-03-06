module Challenge1 exposing (..)

import Color exposing (Color, black, lightBlue, purple, white)
import Element exposing (Element, centered, color, container, middle, show, toHtml)
import Html exposing (Html, text)
import Mouse exposing (Position)
import Task
import Text exposing (Text)
import Window exposing (Size)


type alias Model =
    { size : Size
    , position : Position
    }


type Msg
    = MouseMove Position
    | SizeChange Size


coloredText : String -> Color -> Text
coloredText text color =
    Text.color color (Text.fromString text)


update : Msg -> Model -> Model
update msg model =
    case msg of
        MouseMove position ->
            { model | position = position }

        SizeChange size ->
            { model | size = size }


view : Model -> Html Msg
view model =
    let
        ( w, h ) =
            ( model.size.width, model.size.height )

        ( backgroundColor, textColor, text ) =
            if model.position.x < w // 2 then
                ( purple, white, "Left" )
            else
                ( lightBlue, black, "Right" )
    in
    toHtml <|
        color purple <|
            container w h middle <|
                centered (coloredText text textColor)


init : ( Model, Cmd Msg )
init =
    ( { size = Size 0 0
      , position = Position 0 0
      }
    , Task.perform SizeChange Window.size
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Window.resizes SizeChange
        , Mouse.moves MouseMove
        ]


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = \msg model -> ( update msg model, Cmd.none )
        , view = view
        , subscriptions = subscriptions
        }
