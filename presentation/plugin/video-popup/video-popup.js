document.querySelectorAll(".videoTrigger").forEach((item) => {
  item.addEventListener("click", function () {
    let videoSource = this.getAttribute("data-video-src");
    let videoContainer = document.createElement("div");
    videoContainer.innerHTML = `
        <div class="videoContainer" style="display: block;">
          <video controls class="r-stretch" autoplay>
            <source src="${videoSource}" type="video/mp4">
            Your browser does not support the video tag.
          </video>
        </div>`;
    document.body.appendChild(videoContainer);

    // Style the videoContainer or add functionality to close it on click outside or with a button
    videoContainer.style.position = "fixed";
    videoContainer.style.top = "50%";
    videoContainer.style.left = "50%";
    videoContainer.style.transform = "translate(-50%, -50%)";
    videoContainer.style.zIndex = "1000";
    videoContainer.style.backgroundColor = "white";
    videoContainer.style.padding = "20px";
    videoContainer.style.boxShadow = "0 4px 8px rgba(0,0,0,0.2)";
    videoContainer.addEventListener("click", function () {
      videoContainer.remove(); // Closes the video container when clicked
    });
  });
});
