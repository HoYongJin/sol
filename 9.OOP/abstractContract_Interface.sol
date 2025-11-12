// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// ==========================================================================================
// 1. 인터페이스 (Interface): "게시물의 자격"
// ==========================================================================================
// 우리 시스템에서 '게시물'로 인정받기 위해 반드시 가져야 할 기능 목록(API 명세)입니다.
// "무엇을" 할 수 있는지만 정의합니다. (예: "내용을 보여줄 수 있어야 한다")
// 상태 변수나 구현된 코드가 전혀 없는 순수한 '규칙'입니다
interface IPost {
    function display() external view returns(string memory);

    function getAuthor() external view returns(address);
}

// ==========================================================================================
// 2. 추상 컨트랙트 (Abstract Contract): "게시물의 기본 뼈대"
// ==========================================================================================
// 모든 게시물(글, 사진 등)이 공통으로 사용할 기능과 데이터를 담은 '미완성 템플릿'입니다.
// '작성자' 정보는 모든 게시물에 공통이므로 여기서 미리 구현하여 코드 중복을 방지합니다.
// 하지만 '내용을 보여주는 방식'은 게시물 종류마다 다르므로 미완성 상태로 남겨둡니다.
abstract contract BasePost is IPost {
    address private _author;

    constructor() {
        _author = msg.sender;
    }

    // getAuthor 함수는 모든 자식 컨트랙트가 공통으로 사용
    // IPost 인터페이스의 규칙을 따르므로 'override' 키워드를 사용
    function getAuthor() external view override returns(address) {
        return _author;
    }

    // --- 미구현 함수 (이것 때문에 추상 컨트랙트가 됨) ---
    // display 함수는 자식 컨트랙트가 자신의 형태에 맞게 완성해야함
    function display() external view virtual returns (string memory);
}

contract ArticlePost is BasePost {
    string private _textContent;

    constructor(string memory _text) {
        _textContent = _text;
    }

    function display() external view override returns(string memory) {
        return _textContent;
    }
}

contract ImagePost is BasePost {
    string private _imageUrl;

    constructor(string memory imageUrl) {
        _imageUrl = imageUrl;
    }

    function display() external view override returns (string memory) {
        return string.concat("Image URL: ", _imageUrl);
    }
}

contract PostViewer {
    function viewPost(IPost post) public view returns(string memory, address) {
        return (post.display(), post.getAuthor());
    }
}