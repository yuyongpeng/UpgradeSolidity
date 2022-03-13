pragma solidity ^0.8.0;

import "./@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "./@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol"; 
import "./@openzeppelin/contracts-upgradeable/token/ERC721/ERC721Upgradeable.sol"; 
import "./@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721BurnableUpgradeable.sol"; 
import "./@openzeppelin/contracts-upgradeable/token/ERC721/extensions/ERC721URIStorageUpgradeable.sol"; 


contract TopholderData {
    string internal _baseUri;
    mapping (address => uint) admins;
    mapping (uint256 => bool) internal _tokenIdType;
    mapping (address => uint) internal _wards;
}

contract Topholder is Initializable, OwnableUpgradeable, ERC721URIStorageUpgradeable, IERC721ReceiverUpgradeable, TopholderData {

    event SetTokenIdType(uint256, bool); 

	function initialize()public initializer{
        admins[msg.sender] = 1;
        __ERC721_init("topholder", "TP");
		__Context_init_unchained();
		__Ownable_init_unchained();
	} 

    modifier onlyAuth {
        require(admins[msg.sender] == 1, "not-authorized");
        _;
    }
    /**
     * owner 设置 管理者
     */
    function setAdmin(address admin_) external onlyOwner {
        admins[admin_] = 1;
    }

    /**
     * 管理者 设置 其他权限
     */
    function rely(address guy) external onlyAuth { admins[guy] = 1; }

    function deny(address guy) external onlyAuth { admins[guy] = 0; }

    function relyOper(address oper) external onlyAuth { _wards[oper] = 1;}

    function denyOper(address oper) external onlyAuth { _wards[oper] = 0;}


    // constructor() ERC721("Dphotos", "DPT") {
    //     admins[msg.sender] = 1;
    // }

    /**
    * create a unique token
    */
    function mintUniqueTokenTo(address to, uint256 tokenId, string memory uri, bool idType) public {
        super._mint(to, tokenId, idType);
        super._setTokenURI(tokenId, uri);
    }

    function setTokenIdType(uint256 tokenId, bool idType) public onlyAuth{
        _setTokenIdType(tokenId, idType);
    }

    function _setTokenIdType(uint256 tokenId, bool idType) internal virtual {
        _tokenIdType[tokenId] = idType;
        emit SetTokenIdType(tokenId, idType);
    }




    /**
     * 只有owner和授权者，才有权限销毁NFT
     */
    function burn(uint256 tokenId) public virtual {
        //solhint-disable-next-line max-line-length
        require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721Burnable: caller is not owner nor approved");
        _burn(tokenId);
    }

    /**
     * 设置NFT的 baseUri
     */
    function setBaseURI(string memory baseUri_) internal {
        _baseUri = baseUri_;
    }

    /**
     *  定义NFT的baseURI
     */
    function _baseURI() internal view virtual override  returns (string memory) {
        return _baseUri;
    }


    /**
     * @dev Safely mints `tokenId` and transfers it to `to`.
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - If `to` refers to a smart contract, it must implement {IERC721Receiver-onERC721Received}, which is called upon a safe transfer.
     *
     * Emits a {Transfer} event.
     */
    function _safeMint(address to, uint256 tokenId, bool idType) internal virtual {
        _safeMint(to, tokenId, idType, "");
    }

    /**
     * @dev Same as {xref-ERC721-_safeMint-address-uint256-}[`_safeMint`], with an additional `data` parameter which is
     * forwarded in {IERC721Receiver-onERC721Received} to contract recipients.
     */
    function _safeMint(
        address to,
        uint256 tokenId,
        bool idType,
        bytes memory _data
    ) internal virtual {
        _mint(to, tokenId, idType);
        require(
            super._checkOnERC721Received(address(0), to, tokenId, _data),
            "ERC721: transfer to non ERC721Receiver implementer"
        );
    }

    /**
     * @dev Mints `tokenId` and transfers it to `to`.
     *
     * WARNING: Usage of this method is discouraged, use {_safeMint} whenever possible
     *
     * Requirements:
     *
     * - `tokenId` must not exist.
     * - `to` cannot be the zero address.
     *
     * Emits a {Transfer} event.
     */
    function _mint(address to, uint256 tokenId, bool idType) internal virtual {
        require(to != address(0), "ERC721: mint to the zero address");
        require(!_exists(tokenId), "ERC721: token already minted");

        _beforeTokenTransfer(address(0), to, tokenId);

        super._balances[to] += 1;
        super._owners[tokenId] = to;

        _tokenIdType[tokenId] = idType;

        emit Transfer(address(0), to, tokenId);

        _afterTokenTransfer(address(0), to, tokenId);
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        if (_tokenIdType[tokenId] == true) {
            require(_wards[_msgSender()] == 1, "ERC721: transfer caller is not operator");
        } else {
            //solhint-disable-next-line max-line-length
            require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        }

        _transfer(from, to, tokenId);
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public virtual override {
        if (_tokenIdType[tokenId] == true) {
            require(_wards[_msgSender()] == 1);
        } else {
            require(_isApprovedOrOwner(_msgSender(), tokenId), "ERC721: transfer caller is not owner nor approved");
        }
        _safeTransfer(from, to, tokenId, _data);
    }
    
    /**
     * 成功后的回调
     */
    function onERC721Received(
        address operator,
        address from,
        uint256 tokenId,
        bytes calldata data
    ) external returns (bytes4){
        return this.onERC721Received.selector;
    }


    /**
     * @dev This empty reserved space is put in place to allow future versions to add new
     * variables without shifting down storage in the inheritance chain.
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     */
    // uint256[44] private __gap;
}