import { useLocation, useNavigate } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';

export default function PageHeader({ title, backTo = '/', right }) {
  const location = useLocation();
  const navigate = useNavigate();

  const handleBack = () => {
    if (location.key !== 'default') {
      navigate(-1);
    } else {
      navigate(backTo, { replace: true });
    }
  };

  return (
    <header className="page-header">
      <button type="button" onClick={handleBack} className="icon-btn" aria-label="Kembali">
        <ArrowLeft size={20} aria-hidden="true" />
      </button>
      <h1>{title}</h1>
      <div className="page-header__right">{right}</div>
    </header>
  );
}
