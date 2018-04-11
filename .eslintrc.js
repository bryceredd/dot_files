module.exports = {
  globals: {
    window: true
  },
  env: {
    browser: true,
    es6: true,
    node: true
  },
  extends: ["prettier"],
  parserOptions: {
    ecmaVersion: 8,
    ecmaFeatures: {
      experimentalObjectRestSpread: true,
      jsx: true
    },
    sourceType: "module"
  },
  plugins: ["react"],
  rules: {
    "no-console": "off",
    indent: [2, 2, { SwitchCase: 1 }],
    "linebreak-style": ["error", "unix"],
    quotes: ["error", "double"],
    semi: ["error", "always"],
    "space-before-function-paren": 0,
    "comma-dangle": 0
  }
};
