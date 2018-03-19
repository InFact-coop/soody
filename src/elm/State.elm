port module State exposing (..)

import Data.Hotspots exposing (..)
import Data.Log exposing (defaultLog)
import Data.Stim exposing (defaultStim)
import Data.View exposing (..)
import Helpers.Util exposing (scrollToTop)
import Ports exposing (..)
import Navigation exposing (..)
import Types exposing (..)


initModel : Model
initModel =
    { view = Landing
    , userId = ""
    , avatar = Avatar1
    , avatarName = "Hello"
    , avatarSkinColour = Skin1
    , stims = []
    , logs = []
    , newStim = defaultStim
    , newLog = defaultLog
    , counter = 0
    , paused = False
    , showNav = Neutral
    , hotspots = defaultHotspots
    }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    let
        model =
            viewFromUrl location initModel
    in
        model ! [ initHotspots () ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
            { model | view = getViewFromRoute location.hash }
                ! (scrollToTop :: viewToCmds model.view)

        RecieveHotspotCoords (Ok coords) ->
            { model | hotspots = coords } ! []

        RecieveHotspotCoords (Err err) ->
            model ! []

        ToggleNav ->
            { model | showNav = updateNav model.showNav } ! []

        NoOp ->
            model ! []
