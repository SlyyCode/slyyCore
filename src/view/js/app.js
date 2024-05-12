const types = {
    ["success"]: {
        ["icon"]: "check_circle",
    },
    ["error"]: {
        ["icon"]: "error",
    },
    ["info"]: {
        ["icon"]: "info",
    },
};
const codes = {
    "~r~": "red",
    "~b~": "#378cbf",
    "~g~": "green",
    "~y~": "yellow",
    "~p~": "purple",
    "~c~": "grey",
    "~m~": "#212121",
    "~u~": "black",
    "~o~": "orange",
};
let textInfo;

window.addEventListener("message", (event) => {
    if (event.data.action == "notification") {
        notification({
            type: event.data.type,
            message: event.data.message,
            length: event.data.length,
        });
    } else if (event.data.action == "textInfo") {
        if (!textInfo) {
            textInfo = $(`
                <div class="notify info">
                    <div class="innerText">
                        <p class="text"></p>
                    </div>
                </div>
            `).appendTo(`#root`);
        }
        textInfo.find('.text').text(event.data.message);
    } else if (event.data.action == "stopTextInfo") {
        if (textInfo) {
            textInfo.fadeOut(700, function() {
                $(this).remove();
            });
        }
    }
});

const replaceColors = (str, obj) => {
    let strToReplace = str;

    for (let id in obj) {
        strToReplace = strToReplace.replace(new RegExp(id, "g"), obj[id]);
    }

    return strToReplace;
};

notification = (data) => {
    for (color in codes) {
        if (data["message"].includes(color)) {
            let objArr = {};
            objArr[color] = `<span style="color: ${codes[color]}">`;
            objArr["~s~"] = "</span>";

            let newStr = replaceColors(data["message"], objArr);

            data["message"] = newStr;
        }
    }

    const notification = $(`
        <div class="notify ${data.type}">
            <div class="innerText">
                <span class="material-symbols-outlined icon">${types[data.type]["icon"]}</span>
                <p class="text">${data["message"]}</p>
            </div>
        </div>
    `).appendTo(`#root`);

    setTimeout(() => {
        notification.fadeOut(700);
    }, data.length);

    return notification;
};