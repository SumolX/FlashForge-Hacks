function postCommand(url) {
    (async () => {
        const res = await fetch(url, {});
    })();
}

function onPrintPause() {
    if (confirm("Are your sure you want to pause printing?") == true) {
        postCommand('/cgi-bin/printer?pause');
    }
}

function onPrintResume() {
    if (confirm("Are your sure you want to resume printing?") == true) {
        postCommand('/cgi-bin/printer?resume');
    }
}

function onPrintCancel() {
    if (confirm("Are your sure you want to cancel printing?") == true) {
        postCommand('/cgi-bin/printer?cancel');
    }
}

let lightIsOn = false;

function onToggleLight() {
    if (lightIsOn) {
        postCommand('/cgi-bin/printer?lightoff');
    } else {
        postCommand('/cgi-bin/printer?lighton');
    }
    lightIsOn = !lightIsOn;
}

function initPage() {
    let canvas = document.getElementById("touchScreen");
    let ctx = canvas.getContext("2d");
    let width = 800;
    let height = 480;
    canvas.width = width;
    canvas.height = height;

    function refreshCameraURL() {
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (this.readyState == 4 && this.status == 200) {
                document.getElementById("liveCamera").src = xhttp.responseText;
            }
        };
        xhttp.open("GET", "cgi-bin/printer?camera", true);
        xhttp.send();
    }

    function refreshMenu() {
        fetch("menu.fb")
        .then(response => response.arrayBuffer())
        .then(array_buffer => {
            let inbuffer = new Uint8ClampedArray(array_buffer);
            let tmpbuffer = new Uint8ClampedArray(width * height * 4);
    
            for (let row = 0; row < height; row++) {
                for (let col = 0; col < width; col++) {
                    let srcidx = 2 * (row * width + col);
                    let dstidx = 4 * (row * width + col);
                    tmpbuffer[dstidx + 2] = (inbuffer[srcidx] & 0x1f) << 3; // RED
                    tmpbuffer[dstidx + 1] = (((inbuffer[srcidx + 1] & 0x7) << 3) | (inbuffer[srcidx] & 0xE0) >> 5) << 2; // GREEN
                    tmpbuffer[dstidx + 0] = (inbuffer[srcidx + 1] & 0xF8); // BLUE
                    tmpbuffer[dstidx + 3] = 255; // ALPHA
                }
            }
    
            let image_data = new ImageData(tmpbuffer, width, height);
            ctx.putImageData(image_data, 0, 0);
            canvas.style.border = "1px solid black";
        });
    }

    refreshCameraURL();
    setInterval(refreshMenu, 500);
}
