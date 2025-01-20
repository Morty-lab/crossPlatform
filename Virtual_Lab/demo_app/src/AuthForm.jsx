import React, { useState, useRef, useEffect } from 'react';
import gsap from 'gsap';
import { ReactSVG } from 'react-svg';
import './authForm.scss';
import { Formik } from 'formik';


import CustomButton from '../buttons/CustomButtons';

import logoImage from '../../assets/images/logo.png';
import begoniaLeaf from '../../assets/images/begonia_leaf.svg';
import useFetch from '../../hooks/useFetch'


import { GoogleLogo, Envelope, ArrowLeft } from '@phosphor-icons/react';




const AuthForm = ({ activate, state }) => {
  const [isActive, setIsActive] = useState(false);
  const leafRef = useRef(null);
  const [errorExist, setErrorExist] = useState(false)

  const { handleGoogle, loading, error } = useFetch(
    `${import.meta.env.VITE_BASE_URL}/auth/register/google`
  );



  useEffect(() => {
    /* global google */
    if (window.google) {
      google.accounts.id.initialize({
        client_id:
          "374457232050-dd18e80eigqj9h1e89nd53vsg3rbrh8p.apps.googleusercontent.com",
          callback: handleGoogle,
      });

      const handleGoogleSignIn = () => {
        console.log('Google Sign-In Button Clicked');
        console.log(error);
        google.accounts.id.prompt()
      }; 

      // Attach the event listener to the button when it becomes available
      const observer = new MutationObserver((mutations) => {
        mutations.forEach((mutation) => {
          if (mutation.addedNodes.length >  0) {
            const customButton = document.querySelectorAll('.google-login');
            customButton.forEach((button) => {
              button.addEventListener('click', handleGoogleSignIn);
            });
          }
        });
      });

      // Start observing the document with the configured parameters
      observer.observe(document.body, { childList: true, subtree: true });

      // Clean up the observer when the component unmounts
      return () => observer.disconnect();
    }
  },[]);


  



  const [activatedForm, setActivatedForm] = useState(activate);
  const [closed, setClosed] = useState(state)


  useEffect(() => {

    setActivatedForm(activate)

    gsap.from(".auth-form-container", {y: -2000, opacity:1, duration: .5, delay:0, ease:"elastic.inOut"})
    gsap.to(".auth-form-container", {y: 0, opacity:1, duration: .5, delay:0,  ease:"elastic.inOut"})
  }, [activate]);


  const handleCloseModal = () => { 
    gsap.to(".auth-form-container", {y: -2000, opacity:1, duration: .5, delay:0,  ease:"elastic.inOut"})
    setClosed("")
  }
  // setActivatedForm("active-user-authentication")

  const handleSwitchClick = (toActivate) => {


    let duration = 4

    for (let counter = 0; counter < duration; counter++) {

      counter == duration - 2 && setActivatedForm(toActivate)
      console.log(counter)
    }



  };

  const handleSubmitRegister = () => {



  }

  return (
    <div className="auth-form-container" >
      <div className="modal-closer"onClick={()=> {handleCloseModal()}} ></div>
      <div className="form-container">
        <div className={`form-wrapper ${activatedForm}`}>

          {/* Login Form starts */}
          <div className="login-container">
            <div className="upper-part">
              <img src={logoImage} alt="" className="logo" />
              <h4>Login to BegoniaLab</h4>
              <p>Explore the Lab</p>
            </div>

            <div className="lower-part">

            {/* onClick={() => handleSwitchClick("active-login")}  */}
              <button className="google-login" onClick={() => handleSwitchClick("active-login")}>
                <GoogleLogo size={18} weight="bold" />
                Login with Google
              </button>
     
            </div>
          </div>


          {/* Login Container Ends */}
          {/* <img src={begoniaLeaf} className='leaf-divider' alt="Leaf" /> */}
          {/* Signup Container */}

          {
            activatedForm == "active-register" &&

            <div className="login-container">
            <div className="upper-part">
              <img src={logoImage} alt="" className="logo" />
              <h4>Login to BegoniaLab</h4>
              <p>Explore the Lab</p>
            </div>

            <div className="lower-part">


              <button className="" >
                <GoogleLogo size={18} weight="bold" />
                Login with Google
              </button >
     
            </div>
          </div>


          }
          {/* Form for user Authentication */}
          {activatedForm == "active-user-authentication" &&

            <div className="email-login">

              <div className="upper-part">
                <img src={logoImage} alt="" className="logo" />
                <h4>Let's Setup you Account</h4>

              </div>

              <div className="lower-part">

                <div className="forms">
                  <div className="email">
                    <label htmlFor="">Enter your Username</label>
                    <input placeholder="Username" type="text" name="email" id="" />

                  </div>
                  <div className="email">
                    <p>
                      Are you a Student or a Teacher?
                    </p>

                  </div>

                </div>

                <div className="lower-actions">
                  <div className="back-btn" onClick={() => handleSwitchClick("active-login")}>
                    <ArrowLeft size={20} weight="bold" />
                    Back
                  </div>
                  <button className="login-btn">Login</button>

                </div>
              </div>



            </div>
          }

        </div>
      </div>
    </div>
  );
};

export default AuthForm;
// export { handleSwitchClick };

