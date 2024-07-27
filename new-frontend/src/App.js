import React, { useState } from 'react';
import axios from 'axios';

function App() {
    const [num1, setNum1] = useState('');
    const [num2, setNum2] = useState('');
    const [result, setResult] = useState(null);

    const handleClick = async () => {
        try {
            const response = await axios.post('http://127.0.0.1:8000/api/sum/', {
                num1: parseInt(num1, 10),
                num2: parseInt(num2, 10)
            });
            setResult(response.data.result);
        } catch (error) {
            console.error('There was an error!', error);
        }
    };

    return (
        <div>
            <h1>Sum of Two Numbers</h1>
            <input
                type="number"
                value={num1}
                onChange={(e) => setNum1(e.target.value)}
                placeholder="Enter first number"
            />
            <input
                type="number"
                value={num2}
                onChange={(e) => setNum2(e.target.value)}
                placeholder="Enter second number"
            />
            <button onClick={handleClick}>Get Sum</button>
            {result !== null && <h2>Result: {result}</h2>}
        </div>
    );
}

export default App;
