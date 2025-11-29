export default {
  darkMode: 'class',
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      colors: {
        main: "#F77433",
        subMain: "#FFCC9C",
        fontMain: "#FAFBFC",
        hidebar: "#161B22",
        background: "#0D1117",
        component: "#1B1F26",
        fontSec: "#C9D1D9",
      },
      backgroundColor: {
        'light': '#ffffff',
        'dark': '#0D1117',
        'dark-secondary': '#161B22',
        'dark-component': '#1B1F26',
      },
      textColor: {
        'light': '#1a1a1a',
        'dark': '#FAFBFC',
        'dark-secondary': '#8B949E',
      },
    },
  },
  plugins: [],
}
