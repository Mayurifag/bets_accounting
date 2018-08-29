process.env.NODE_ENV = process.env.NODE_ENV || "development";

const environment = require("./environment");

// TODO: Configure PurgeCSS
// const PurgecssPlugin = require("purgecss-webpack-plugin");
// const fs = require("fs");
// const glob = require("glob-all");
// const path = require("path");
//
// var whitelist_path = "config/whitelist.json";
// var whitelist = [];
//
// if (fs.existsSync(whitelist_path)) {
//   whitelist = JSON.parse(fs.readFileSync(whitelist_path));
// }
//
// environment.plugins.append(
//   "PurgecssPlugin",
//   new PurgecssPlugin({
//     paths: glob.sync([path.join(__dirname, "../../app/views/**/*.html.slim")]),
//     whitelist
//   })
// );

module.exports = environment.toWebpackConfig();
