export default function Badge({ tipus, children }) {
  return (
    <span className={`badge badge-${tipus}`}>
      {children}
    </span>
  );
}
