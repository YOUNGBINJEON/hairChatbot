const chatButton = document.querySelector('.chatbox__button');
const chatContent = document.querySelector('.chatbox__support');
const icons = {
  	isClicked: "<img src= resources/imgs/text_message1.png />",
    isNotClicked: "<img src= resources/imgs/text_message2.png />"
}
const chatbox = new InteractiveChatbox(chatButton, chatContent, icons);
chatbox.display();
chatbox.toggleIcon(false, chatButton);