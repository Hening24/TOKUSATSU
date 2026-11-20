export default function GlassPanel({ children, className = '', as: Tag = 'div', ...props }) {
  return (
    <Tag className={`glass-wrap${className ? ` ${className}` : ''}`} {...props}>
      {children}
    </Tag>
  );
}
