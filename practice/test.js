const container = document.querySelector("#container");
const content = document.createElement('div');
const para = document.createElement('p');
const heading3 = document.createElement('h3');
const heading1 = document.createElement('h1');
const fancyDiv = document.querySelector(".fancyDiv");


content.classList.add('content');
content.textContent = "This is the glorious text-content!";

container.appendChild(content);

para.style.color = "red";
para.textContent = "Hey I'm red!"

container.appendChild(para);

heading3.style.color = "blue"
heading3.textContent = "I'm a blue h3!"

container.appendChild(heading3);
 
content.classList.add('fancyDiv');
fancyDiv.style.cssText = 'background-color: blue; border: thick solid black';

container.appendChild(content);

heading1.textContent = "I'm in a div";
content.appendChild(heading1);

para.textContent = "ME TOO!";
fancyDiv.appendChild(para);
container.appendChild(fancyDiv);

const btn = document.querySelector('#btn');
btn.addEventListener('click', function (e) {
    e.target.style.background = 'blue';
});