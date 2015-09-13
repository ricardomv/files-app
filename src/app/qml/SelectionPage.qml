/*
* Files app - File manager for Papyros
* Copyright (C) 2015 Michael Spencer <sonrisesoftware@gmail.com>
*               2015 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
*
* This program is free software: you can redistribute it and/or modify
* it under the terms of the GNU General Public License as published by
* the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* This program is distributed in the hope that it will be useful,
* but WITHOUT ANY WARRANTY; without even the implied warranty of
* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License
* along with this program. If not, see <http://www.gnu.org/licenses/>.
*/
import QtQuick 2.2
import Material 0.1
import "components"

Page {
    id: folderPage

    title: qsTr("Select files...")

    backAction: Action {
        iconName: "navigation/arrow_back"
        name: qsTr("Back")

        onTriggered: {
            selectionManager.clear()
            selectionManager.mode = 0
            folderPage.pop()
        }
    }

    actions: [
        Action {
            iconName: "content/content_cut"
            name: qsTr("Cut")
            onTriggered: folderModel.model.cutSelection()
        },
        Action {
            iconName: "content/content_copy"
            name: qsTr("Copy")
            onTriggered: folderModel.model.copySelection()
        },
        Action {
            iconName: "content/content_paste"
            name: qsTr("Paste")
            onTriggered: folderModel.model.paste()
            enabled: folderModel.model.clipboardUrlsCounter
        },
        Action {
            iconName: "action/delete"
            name: qsTr("Delete")
            onTriggered: folderModel.model.moveSelectionToTrash()
        },
        Action {
            iconName: "content/select_all"
            name: qsTr("Select all")
            onTriggered: selectionManager.selectAll()
        },
        Action {
            iconName: "content/clear"
            name: qsTr("Clear selection")
            onTriggered: selectionManager.clear()
        },
        Action {
            iconName: "action/assignment"
            name: qsTr("Properties")
        },
        Action {
            iconName: "action/help"
            name: qsTr("Rename")
        },
        Action {
            iconName: "action/help"
            name: qsTr("Compress")
        }
    ]

    actionBar {
        elevation: 0
        backgroundColor: Palette.colors["grey"]["800"]
    }

    FolderListView {
        anchors.fill: parent
        model: folderModel.model
        delegate: SelectionListItem {}
    }

    Keys.onEscapePressed: selectionManager.clear()
}
