// useFetch.jsx
import { useState } from "react";
import handleSwitchClick from '../components/forms/AuthForm';

const useFetch = (url) => {
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");

  const handleGoogle = async (response) => {
    // Log the token to the console
    console.log("reached");
    console.log(response);
  
    setLoading(true);
    try {
      const res = await fetch(url, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({ credential: response.credential }),
      });
  
      const data = await res.json();
      if (data?.user) {
        localStorage.setItem("user", JSON.stringify(data?.user));
        handleSwitchClick("active-user-authentication");
      } else {
        throw new Error(data?.message || data);
      }
    } catch (error) {
      setError(error?.message);
    } finally {
      setLoading(false);
    }
  };
  
  return { loading, error, handleGoogle };
};

export default useFetch;
