pragma solidity ^0.5.11;

contract SongFact
{
    mapping(string=>address) public registeredAdmin;
    function newAdmin(string memory admin_name) public
    {
        address admin=address(new Songs(msg.sender, admin_name));
        registeredAdmin[admin_name]=admin;
    }
}

contract Songs
{
    address owner;
    string adminname;
    constructor(address sender_name, string memory admin) public
    {
        owner = sender_name;
        adminname = admin;
    }
    struct Details {
        string admin_name;
        string song_name;
        string artist;
        uint256 upload_date;
    }
     modifier onlyOwner()
    {
        require(msg.sender==owner);
        _;
    }


    mapping(uint256 => Details) public songlist;

    function storeSongs(uint256 id, string memory songname, string memory artistname, uint256 date) public onlyOwner
        {
        require(songlist[id].upload_date == 0, "The Entry Already Exists");
        songlist[id] = Details(adminname, songname, artistname, date);
        }

        function getSongs(uint256 _id) public view returns(string memory, string memory, string memory, uint256)
       {
           Details memory temp = songlist[_id];
           require(temp.upload_date != 0, "No such song uploaded");
           return (temp.song_name, temp.admin_name, temp.artist, temp.upload_date);
       }
}
