import ReactDOM from 'react-dom/client';
import App from './components/App';
import './index.css';
import '@mantine/core/styles.css';
import { MantineProvider } from '@mantine/core';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <MantineProvider>
    <App />
  </MantineProvider>,
);