export default function Brand({ title, subtitle }) {
  return (
    <>
      <div className="brand">
        <h1>{title}</h1>
        {subtitle && <p>{subtitle}</p>}
      </div>
      <div className="strip" aria-hidden="true">
        <i /><i /><i /><i /><i />
      </div>
    </>
  );
}
