module Views.StimPreparation exposing (..)

import Components.Button exposing (..)
import Components.FeelingButtons exposing (..)
import Data.Face exposing (faces, urlFromFace)
import Data.Feelings exposing (feelings)
import Helpers.Utils exposing (unionTypeToString, stringToFloat)
import Html exposing (..)
import Html.Attributes as H exposing (..)
import Html.Events exposing (onClick, onInput, targetValue, on)
import Json.Decode as Json
import Types exposing (..)


stimPreparation : Model -> Html Msg
stimPreparation model =
    div [ class "border-box bg-green w-100 h-100 flex-column tc" ]
        [ div [] []
        , div [ style [ ( "backgroundImage", "url(./assets/StimPreparation/zigzag_how_you_feel_before_bg.svg)" ) ], class "ma3 mb4 flex-column" ]
            [ div []
                [ img [ src "./assets/StimPreparation/back_btn_white.svg" ] []
                ]
            , p [ class "bg-green h-20" ] [ text "TESTING UPDATE" ]
            , div []
                [ img [ src "./assets/Landing/menu-drawer/about_btn.svg" ] []
                ]
            , div []
                [ div []
                    [ img [] []
                    , p [] [ text "Before we start:" ]
                    ]
                , p [] [ text "How long do you want to do the exercise for?" ]
                , div [ class "w-80 items-center justify-between tc inline-flex center" ]
                    [ input [ id "myRange", type_ "range", H.min "0", H.max "1800", step "60", class "w-75 bg-light-gray input-reset h-custom slider", onInputValue SetTime ]
                        []
                    , div
                        [ class "bg-center"
                        , style
                            [ ( "backgroundImage", "url(./assets/StimPreparation/slider_counter_tag.svg)" )
                            ]
                        ]
                        [ text (unionTypeToString (model.timeSelected / 60)) ]
                    ]
                , p [] [ text "How are you?" ]
                , div [ class "flex flew-row" ] (List.map face faces)
                , div []
                    [ p [] [ text "Any specific feelings?" ]
                    , div [ class "flex flex-wrap items-center justify-around" ] (renderFeelings feelings)
                    ]
                , rectButton "Next" (ChangeView StimTimer)
                ]
            ]
        ]


renderFeelings : List Feeling -> List (Html Msg)
renderFeelings list =
    List.map (feelingButton Pre) list


face : Face -> Html Msg
face face =
    div [ onClick <| ToggleFace Pre face ]
        [ img [ src (urlFromFace face) ] []
        ]


onInputValue : (String -> msg) -> Attribute msg
onInputValue tagger =
    on "input" (Json.map tagger targetValue)
