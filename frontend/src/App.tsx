import {Hello} from "./helloworld"
import './App.css'

function App() {
  const handleClick = () => {
    Hello()
  }

  return (
    <div className="App">
      <div className="card">
        <button onClick={handleClick}>Click me</button>
      </div>
    </div>
  )
}

export default App
