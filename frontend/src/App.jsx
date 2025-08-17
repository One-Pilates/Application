import { useState } from 'react'
import './styles/App.css'

function App() {
  const [count, setCount] = useState(0)

  return (
    <div className="page">
        <h1 className="title">EM BREVE — ONE PILATES</h1>
        <img className="logo" src="./src/assets/logoOriginal.png" alt="One Pilates" />
      <footer className="footer">© {new Date().getFullYear()} One Pilates</footer>      
    </div>
  )
}

export default App
