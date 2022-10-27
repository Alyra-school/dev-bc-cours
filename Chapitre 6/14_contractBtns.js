import { useState } from "react";
import useEth from "../../contexts/EthContext/useEth";

function ContractBtns({ setValue, setText }) {
  const { state: { contract, accounts } } = useEth();
  const [inputValue, setInputValue] = useState("");
  const [textInput, setTextInput]=useState("text");

  const handleInputChange = e => {
    if (/^\d+$|^$/.test(e.target.value)) {
      setInputValue(e.target.value);
    }
  };
  const handleTextChange = e => {
    setTextInput(e.target.value);
  };

  const read = async () => {
    const value = await contract.methods.read().call({ from: accounts[0] });
    setValue(value);
  };

  const write = async e => {
    if (e.target.tagName === "INPUT") {
      return;
    }
    if (inputValue === "") {
      alert("Please enter a value to write.");
      return;
    }
    const newValue = parseInt(inputValue);
    await contract.methods.write(newValue).send({ from: accounts[0] });
  };

  const readText = async () => {
    const value = await contract.methods.greet().call({ from: accounts[0] });
    setText(value);
  };

  const writeText = async e => {
    if (e.target.tagName === "INPUT") {
      return;
    }
    if (textInput === "") {
      alert("Please enter a value to write.");
      return;
    }
    const newValue = textInput;
    await contract.methods.setGreet(newValue).send({ from: accounts[0] });
  };

  return (
    <div className="btns">

      <button onClick={read}>
        read()
      </button>

      <div onClick={write} className="input-btn">
        write(<input
          type="text"
          placeholder="uint"
          value={inputValue}
          onChange={handleInputChange}
        />)
      </div>

      <button onClick={readText}>
        greet()
      </button>

      <div onClick={writeText} className="input-btn">
        setGreet(<input
          type="text"
          placeholder="uint"
          value={textInput}
          onChange={handleTextChange}
        />)
      </div>

    </div>
  );
}

export default ContractBtns;
