const express = require("express");
const path = require("path");

if (!process.env.PORT) {
    throw new Error("Please specify the port number for the HTTP server with the environment variable PORT.");
}

const PORT = process.env.PORT;

//
// Application entry point.
//
async function main() {

    const app = express();

    //
    // Array of advertisements.
    //
    const advertisements = [
        {
            name: "Shopee",
            imageUrl: "/images/shopee.png",
            link: "https://shopee.co.th"
        },
        {
            name: "Lazada",
            imageUrl: "/images/lazada.png",
            link: "https://www.lazada.co.th"
        },
        {
            name: "Kaidee",
            imageUrl: "/images/kaidee.png",
            link: "https://www.kaidee.com"
        }
    ];

    //
    // HTTP GET route to render advertisements view.
    //
    app.get("/advertise", (req, res) => {
        res.json({
            name: "Shopee",
            imageUrl: "/images/shopee.png",
            link: "https://shopee.co.th"
        },
        {
            name: "Lazada",
            imageUrl: "/images/lazada.png",
            link: "https://www.lazada.co.th"
        },
        {
            name: "Kaidee",
            imageUrl: "/images/kaidee.png",
            link: "https://www.kaidee.com"
        });
    });

    //
    // Starts the HTTP server.
    //
    app.listen(PORT, () => {
        console.log(`Advertise microservice online on port ${PORT}`);
    });
}

main()
    .catch(err => {
        console.error("Advertise microservice failed to start.");
        console.error(err && err.stack || err);
    });
