const filelink = artifacts.require("filelink");
const assertRevert = require("./assertRevert");
const expectEvent = require("./expectEvent"); 

contract('filelink', function([deployer, user1, user2]){
    let link;
    let Amount = 5*10**13;
    let tempbyte1 = 'this is magnet';
    
    beforeEach(async () => { 
        console.log('before each')
        link = await filelink.new();
    })

    describe('download',function () {
        it('should fail when the downloaded money is not 0.005 ETH', async () => {
            // Fail transaction
            await assertRevert(link.downloadFile(user1, 'ip is uploaders ip', 'adrs is file address'))
            //transaction obj {chain id, value, to, from, gas(limit),gasprice}
        })

        it.only('should put the que with 1 link', async () => {
            
            let receipt = await link.downloadFile(user1 , tempbyte1 ,{value : Amount} );
            console.log(receipt);
            let contractBalance = await web3.eth.getBalance(link.address);
            assert.equal(contractBalance, Amount);

            let fLink = await link.getFileInfo(0);
           
            console.log('link');
            console.log(fLink.uploader);
            console.log(fLink.magnet);
            
            link.taxCollection(user1, Amount);
            
        })

    })
});