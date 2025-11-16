import React from "react";
import { FaCheck } from "react-icons/fa";

export default function StepIndicator({ steps, currentStep }) {
  return (
    <div style={styles.container}>
      {steps.map((step, index) => {
        const stepNumber = index + 1;
        const isActive = stepNumber === currentStep;
        const isCompleted = stepNumber < currentStep;

        return (
          <div key={stepNumber} style={styles.wrapper}>
            <div style={styles.item}>
              <div
                style={{
                  ...styles.circle,
                  ...(isActive ? styles.circleActive : {}),
                  ...(isCompleted ? styles.circleCompleted : {}),
                }}
              >
                {isCompleted ? <FaCheck size={16} /> : stepNumber}
              </div>
              <span
                style={{
                  ...styles.label,
                  ...(isActive || isCompleted ? styles.labelActive : {}),
                }}
              >
                {step.label}
              </span>
            </div>
            {stepNumber < steps.length && (
              <div
                style={{
                  ...styles.line,
                  ...(isCompleted ? styles.lineCompleted : {}),
                }}
              />
            )}
          </div>
        );
      })}
    </div>
  );
}

const styles = {
  container: {
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    gap: 0,
    marginBottom: '2rem',
    width: '100%',
  },
  wrapper: {
    display: 'flex',
    alignItems: 'center',
    flex: 1,
  },
  item: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    gap: '0.5rem',
    position: 'relative',
    zIndex: 2,
  },
  circle: {
    width: '2.5rem',
    height: '2.5rem',
    borderRadius: '50%',
    display: 'flex',
    alignItems: 'center',
    justifyContent: 'center',
    fontWeight: '600',
    fontSize: '0.875rem',
    backgroundColor: '#e5e7eb',
    color: '#9ca3af',
    transition: 'all 0.3s ease',
  },
  circleActive: {
    backgroundColor: '#f97316',
    color: 'white',
    boxShadow: '0 0 0 4px rgba(249, 115, 22, 0.2)',
  },
  circleCompleted: {
    backgroundColor: '#22c55e',
    color: 'white',
  },
  label: {
    fontSize: '0.75rem',
    color: '#9ca3af',
    fontWeight: '500',
    textAlign: 'center',
    whiteSpace: 'nowrap',
    transition: 'color 0.3s ease',
  },
  labelActive: {
    color: '#1f2937',
  },
  line: {
    height: '2px',
    flex: 1,
    backgroundColor: '#e5e7eb',
    margin: '0 0.5rem',
    marginBottom: '1.5rem',
    transition: 'background-color 0.3s ease',
  },
  lineCompleted: {
    backgroundColor: '#22c55e',
  },
};