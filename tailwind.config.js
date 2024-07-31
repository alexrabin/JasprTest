/** @type {import('tailwindcss').Config} */
const withMT = require("@material-tailwind/html/utils/withMT");
module.exports = withMT({
  content: ["{lib,web}/**/*.dart", "../lib/**/*.dart"],
  theme: {
    extend: {},
  },
  plugins: [],
});
