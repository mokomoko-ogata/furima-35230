document.addEventListener('DOMContentLoaded', function(){
  if ( document.getElementById('item-image')){
    const ImageList = document.getElementById('image-list');

    const createImageHTML = (blob) => {   // 選択した画像を表示する関数
      const imageElement = document.createElement('div');// 画像を表示するためのdiv要素を生成

      const blobImage = document.createElement('img');// 表示する画像を生成
      blobImage.setAttribute('src', blob);
      // 生成したHTMLの要素をブラウザに表示させる
      imageElement.appendChild(blobImage);
      ImageList.appendChild(imageElement);
    };

    document.getElementById('item-image').addEventListener('change', function(e){
      const imageContent = document.querySelector('img');// 画像が表示されている場合のみ、すでに存在している画像を削除する
      if (imageContent){
        imageContent.remove();
      }

      const file = e.target.files[0];
      const blob = window.URL.createObjectURL(file);

      createImageHTML(blob);
    });
  }
});