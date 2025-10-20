// import React from 'react';
// import './Login.scss';

// const LoginView = ({ email, setEmail, password, setPassword, onLogin }) => {
//   return (
//     <div className='login'>
//       <div className='login__container' role='region' aria-label='Formulário de login'>
//         <div className='login__header'>
//           <h1 id='login-title' className='login__title'>
//             Login
//           </h1>
//           <p className='login__subtitle'>Porque seu corpo é único!</p>
//         </div>

//         <form className='login__form' onSubmit={onLogin} aria-describedby='login-help'>
//           <div className='login__field'>
//             <label htmlFor='email' className='login__label'>Email</label>
//             <input
//               type='email'
//               id='email'
//               name='email'
//               value={email}
//               onChange={(e) => setEmail(e.target.value)}
//               className='login__input'
//               required
//             />
//           </div>

//           <div className='login__field'>
//             <label htmlFor='password' className='login__label'>Senha</label>
//             <input
//               type='password'
//               id='password'
//               name='password'
//               value={password}
//               onChange={(e) => setPassword(e.target.value)}
//               className='login__input'
//               required
//             />
//           </div>

//           <button type='submit' className='login__button'>
//             Entrar
//           </button>

//           <div className='login__links' id='login-help'>
//             <a href='#/recuperar-senha' className='login__forgot'>
//               Esqueci minha senha
//             </a>
//             <p className='login__contact'>
//               Precisa de acesso? Contate o administrador.
//             </p>
//           </div>
//         </form>
//       </div>

//       <div className='background-login' aria-hidden='true'>
//         <img src='/logoBranca.png' alt='Logo branca' />
//       </div>
//     </div>
//   );
// };

// export default LoginView;
