// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;


contract filelink{
    // file save data structs
    struct linkInfo{
        string magnet;
        address payable uploader;
    }

    address payable public owner;

    // 일시적으로 파일 다운로드에는 0.05이더씩 값을 받기로 함
    uint256 constant internal DOWN_AMOUNT = 5*10**13;

    //block first & lask index checking values
    uint256 private _tail;
    uint256 private _head;

    mapping (uint256 => linkInfo) private _links;

    event buying(uint256 index, address payable downloader, address payable uploader,uint256 amount);
    event downloading(uint256 index, address uploader, string magnets);

    //블록 상태 변수 하지만 현재 구현내용에서 상세설계 부족으로 사용여부 미정
    enum BlockStatus {checkable, notRebuild, blocklimitedpass}

    //init
    constructor() {
        owner = payable(msg.sender);
    }

    // address != payable address
    function _msgSender() internal view virtual returns (address payable)
    { 
            return payable(msg.sender); // added payable 
    }

    // etherium que push
    function pushLink (address payable uploader, string memory magnet) internal returns(bool result){
        linkInfo memory l;
        l.uploader = uploader;
        l.magnet = magnet;

        _links[_tail] = l;
        _tail++;
        return true;
    }

    //현재 사용하지는 않음 etherium que pop
    /*
    function poplink(uint256 index) internal returns (bool)
    {
        delete _links[index];
        return true;
    }
    */
    
    // if downloader request download file address execute this function
    function downloadFile (address uploader, string memory magnet) public payable returns (bool result)
    {
        //check the proper ether is sent
        require(msg.value == DOWN_AMOUNT , "Not enough ETM");
        //push the download to the que
        require(pushLink(payable(uploader), magnet), "Fail to add a new link Info");
        //email event
        emit buying(_tail-1,_msgSender(), payable(uploader), DOWN_AMOUNT);

        emit downloading(_tail-1,uploader, magnet);
        
        return true;
    }

    // we get some fee for operating this system
    function taxCollection(address addr, uint256 amount) public payable returns (uint256)
    {
        // test fee is 0
        uint256 fee = 0;
        // get eth amount by uploader
        uint256 amountWithoutFee = amount - fee;

        payable(addr).transfer(amountWithoutFee);
        owner.transfer(fee);

        return amountWithoutFee;

    }

    function getFileInfo(uint256 index) public view returns (address payable uploader, string memory magnet)
    {
        linkInfo memory b = _links[index];
        uploader = b.uploader;
        magnet = b.magnet;
    }

    function setFileInfo(uint256 index, address payable uploader, string memory magnet) public returns (bool)
    {
        _links[index];
        _links[index].uploader = uploader;
        _links[index].magnet = magnet;
        return true;
    }


    
}