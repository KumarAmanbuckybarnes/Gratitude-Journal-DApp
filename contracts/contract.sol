// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract GratitudeJournal {
    // Struct to store a gratitude entry
    struct GratitudeEntry {
        address author;
        string entry;
        uint256 timestamp;
    }

    // Array to store all gratitude entries
    GratitudeEntry[] public entries;

    // Event to log when a new gratitude entry is added
    event GratitudeRecorded(address indexed author, string entry, uint256 timestamp);

    // Function to add a new gratitude entry
    function recordGratitude(string memory _entry) public {
        // Ensure the entry is not empty
        require(bytes(_entry).length > 0, "Gratitude entry cannot be empty");

        // Create a new entry and add it to the entries array
        GratitudeEntry memory newEntry = GratitudeEntry({
            author: msg.sender,
            entry: _entry,
            timestamp: block.timestamp
        });

        entries.push(newEntry);

        // Emit an event to log the new entry
        emit GratitudeRecorded(msg.sender, _entry, block.timestamp);
    }

    // Function to retrieve all gratitude entries for a specific address
    function getEntriesByAuthor(address _author) public view returns (GratitudeEntry[] memory) {
        // Create a dynamic array to store matching entries
        GratitudeEntry[] memory authorEntries = new GratitudeEntry[](entries.length);
        uint256 count = 0;

        // Iterate through all entries to find matches
        for (uint256 i = 0; i < entries.length; i++) {
            if (entries[i].author == _author) {
                authorEntries[count] = entries[i];
                count++;
            }
        }

        // Create a new array with exact size to return
        GratitudeEntry[] memory result = new GratitudeEntry[](count);
        for (uint256 i = 0; i < count; i++) {
            result[i] = authorEntries[i];
        }

        return result;
    }
}