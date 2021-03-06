module Data.Avatar exposing (..)

import Helpers.Utils exposing (fileNameFromURL)
import Json.Decode exposing (..)
import Types exposing (..)


decodeAvatar : Decoder Avatar
decodeAvatar =
    Json.Decode.map (stringToAvatar) string


stringToAvatar : String -> Avatar
stringToAvatar avatarStr =
    case avatarStr of
        "Avatar1" ->
            Avatar1

        "Avatar2" ->
            Avatar2

        "Avatar3" ->
            Avatar3

        "Avatar4" ->
            Avatar4

        "Avatar5" ->
            Avatar5

        "Avatar6" ->
            Avatar6

        _ ->
            Avatar1


avatarHeadSelection : Avatar -> String
avatarHeadSelection avatar =
    case avatar of
        Avatar1 ->
            "./assets/avatar_1_head.svg"

        Avatar2 ->
            "./assets/avatar_2_head.svg"

        Avatar3 ->
            "./assets/avatar_3_head.svg"

        Avatar4 ->
            "./assets/avatar_4_head.svg"

        Avatar5 ->
            "./assets/avatar_5_head.svg"

        Avatar6 ->
            "./assets/avatar_6_head.svg"


avatarSrcToAvatar : String -> Avatar
avatarSrcToAvatar string =
    case fileNameFromURL string of
        "avatar_1.svg" ->
            Avatar1

        "avatar_2.svg" ->
            Avatar2

        "avatar_3.svg" ->
            Avatar3

        "avatar_4.svg" ->
            Avatar4

        "avatar_5.svg" ->
            Avatar5

        "avatar_6.svg" ->
            Avatar6

        _ ->
            Avatar1


avatarSelection : Avatar -> String
avatarSelection avatar =
    case avatar of
        Avatar1 ->
            "./assets/CreateAvatar/avatar_1.svg"

        Avatar2 ->
            "./assets/CreateAvatar/avatar_2.svg"

        Avatar3 ->
            "./assets/CreateAvatar/avatar_3.svg"

        Avatar4 ->
            "./assets/CreateAvatar/avatar_4.svg"

        Avatar5 ->
            "./assets/CreateAvatar/avatar_5.svg"

        Avatar6 ->
            "./assets/CreateAvatar/avatar_6.svg"
