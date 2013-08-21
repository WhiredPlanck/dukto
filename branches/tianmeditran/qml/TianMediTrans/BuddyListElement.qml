/* DUKTO - A simple, fast and multi-platform file transfer tool for LAN users
 * Copyright (C) 2011 Emanuele Colombo
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

import QtQuick 1.1

Flipable {
   id: contactDelegateItem
   width: parent.width
   height: buddyIp == "" ? 94 : 64

   property string buddyIp
   property alias buddyGeneric: buddyGenericImage.source
   property alias buddyAvatar: buddyAvatarImage.source
   property alias buddyOsLogo: buddyOsLogoImage.source
   property alias buddyUsername: buddyUsernameText.text
   property alias buddySystem: buddySystemText.text
   property bool buddyShowBack: false

   MouseArea {
       id: buddyMouseArea
       anchors.fill: parent
       hoverEnabled: true
       onClicked: {
           controller.showSendPage(buddyIp);
       }
   }

   Rectangle {
       anchors.left: parent.left
       anchors.right: parent.right
       anchors.top: parent.top
       height: 64
       color: "lightblue"
       opacity: buddyMouseArea.containsMouse?0.5:0
       Behavior on opacity {
           NumberAnimation { duration: 100 }
       }
   }

   front: Item {
       id: temp
       width: contactDelegateItem.width

       Flipable {
           id: flipableAvatar
           width: 64
           height: 64

           front: Rectangle {
               anchors.fill: parent
               color: "lightblue" //theme.color2
               Image {
                   id: buddyGenericImage
                   anchors.fill: parent
               }
               Image {
                   id: buddyAvatarImage
                   anchors.fill: parent
                   smooth: true
               }
           }

           back: Rectangle {
               anchors.fill: parent
               color: "lightblue" //theme.color2
               Image {
                   id: buddyOsLogoImage
                   anchors.fill: parent
               }
           }

           transform: Rotation {
                id: innerRotation
                origin.x: 32
                origin.y: 32
                axis.x: 0; axis.y: 1; axis.z: 0
                angle: 0
           }

           states: [
               State {
                name: "OsState"
                when: buddyShowBack
           }]

           transitions: [
                Transition {
                    from: ""
                    to: "OsState"
                    SequentialAnimation {
                        NumberAnimation { target: innerRotation; property: "angle"; from: 0; to: 180; duration: 400; easing.type: Easing.OutQuad }
                        PauseAnimation { duration: 3000 }
                        NumberAnimation { target: innerRotation; property: "angle"; from: 180; to: 0; duration: 400; easing.type: Easing.OutQuad }
                    }
                }
           ]
       }
       Text {
           id: buddyUsernameText
           anchors.top:  flipableAvatar.top
           anchors.topMargin: 8
           anchors.left: flipableAvatar.right
           anchors.leftMargin: 10
           anchors.right: parent.right
           anchors.rightMargin: 20
           font.pixelSize: 16
           elide: "ElideRight"
           color: "white" //theme.color4
       }
       Text {
           id: buddySystemText
           anchors.left: flipableAvatar.right
           anchors.leftMargin: 10
           anchors.top: buddyUsernameText.bottom
           anchors.topMargin: 5
           anchors.right: parent.right
           anchors.rightMargin: 20
           font.pixelSize: 14
           elide: "ElideRight"
           color: "white" //theme.color4
       }
   }

   transform: Rotation {
        id: rotation
        origin.x: 32
        origin.y: 32
        axis.x: 0; axis.y: 1; axis.z: 0     // set axis.y to 1 to rotate around y-axis
        angle: 0    // the default angle
   }

   ListView.onAdd: NumberAnimation { target: rotation; property: "angle"; from: -90; to: 0; duration: 300; easing.type: Easing.OutCubic }
   ListView.onRemove: SequentialAnimation {
       PropertyAction { target: contactDelegateItem; property: "ListView.delayRemove"; value: true }
       NumberAnimation { target: rotation; property: "angle"; from: 0; to: -90; duration: 300; easing.type: Easing.InCubic }
       PropertyAction { target: contactDelegateItem; property: "ListView.delayRemove"; value: false }

   }

   Rectangle {
       color: "lightblue" //theme.color2
       x: 40
       width: parent.width - 80
       height: 1
       y: parent.height - 10
       visible: buddyIp == ""
   }
}
