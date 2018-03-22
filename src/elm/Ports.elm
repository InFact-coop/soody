port module Ports exposing (..)

import Data.Database exposing (decodeInitialData)
import Data.Hotspots exposing (decodeHotspots)
import Data.Stim exposing (decodeStimList)
import Json.Decode exposing (..)
import Json.Encode exposing (..)
import Time exposing (Time)
import Transit
import Types exposing (..)


port initCarousel : () -> Cmd msg


port videoCarousel : () -> Cmd msg


port saveLog : DBLog -> Cmd msg


port initDB : () -> Cmd msg


port initHotspots : () -> Cmd msg


port saveStim : Json.Encode.Value -> Cmd msg


port receiveHotspotCoords : (Json.Decode.Value -> msg) -> Sub msg


port receiveUpdatedLogs : (List DBLog -> msg) -> Sub msg


port receiveUpdatedStims : (Json.Decode.Value -> msg) -> Sub msg


port receiveInitialData : (Json.Decode.Value -> msg) -> Sub msg


timeSubscription : Model -> Sub Msg
timeSubscription model =
    case model.timerStatus of
        Stopped ->
            Sub.none

        Paused ->
            Sub.none

        Started ->
            Time.every Time.second Tick


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ receiveHotspotCoords (decodeHotspots >> ReceiveHotspotCoords)
        , timeSubscription model
        , receiveUpdatedLogs ReceiveUpdatedLogs
        , receiveUpdatedStims (decodeStimList >> ReceiveStimList)
        , receiveInitialData (decodeInitialData >> ReceiveInitialData)
        , Transit.subscriptions TransitMsg model
        ]
