function postCommand(url) {
    (async () => {
        const res = await fetch(url, {});
    })();
}

function onPrintPause() {
    if (confirm("Are your sure you want to pause printing?") == true) {
        postCommand('/cgi-bin/print-pause');
    }
}

function onPrintResume() {
    if (confirm("Are your sure you want to resume printing?") == true) {
        postCommand('/cgi-bin/print-resume');
    }
}

function onPrintCancel() {
    if (confirm("Are your sure you want to cancel printing?") == true) {
        postCommand('/cgi-bin/print-cancel');
    }
}

function initPage() {
    let canvas = document.getElementById("touchScreen");
    let ctx = canvas.getContext("2d");
    let width = 800;
    let height = 480;
    canvas.width = width;
    canvas.height = height;

    function refreshMenu() {
        fetch("menu.fb")
        .then(response => response.arrayBuffer())
        .then(array_buffer => {
            let inbuffer = new Uint8ClampedArray(array_buffer);
            let tmpbuffer = new Uint8ClampedArray(width * height * 4);
    
            for (row=0; row<height; row++) {
                for (col=0; col<width; col++) {
                    let srcidx = 2 * (row * width + col);
                    let dstidx = 4 * (row * width + col);
                    /* RED   = 0 */
                    tmpbuffer[dstidx+2] = (inbuffer[srcidx] & 0x1f) << 3;
                    /* GREEN = 1 */
                    tmpbuffer[dstidx+1] = (((inbuffer[srcidx+1] & 0x7) << 3) | (inbuffer[srcidx] & 0xE0) >> 5) << 2;
                    /* BLUE  = 2 */
                    tmpbuffer[dstidx+0] = (inbuffer[srcidx+1] & 0xF8);
                    /* ALPHA = 3 */
                    tmpbuffer[dstidx+3] = 255;
                }
            }
    
            let image_data = new ImageData(tmpbuffer, width, height);
            ctx.putImageData(image_data, 0, 0);
            canvas.style.transform = "rotate(-90deg)";
            canvas.style.border = "1px solid black";
        })
    }

    setInterval(refreshMenu, 500);
}
