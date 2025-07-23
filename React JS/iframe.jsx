'use client';
import React, { useRef } from 'react';

const IframeWithPermissions = () => {
  const iframeRef = useRef(null);



  return (
      /*  This component renders an iframe that loads a specific URL.*/
    <div style={{ width: '100vw', height: '100vh', overflow: 'hidden',position: 'relative'}}>
      <iframe
        ref={iframeRef}
        src="https://auraehealth.com"/* Replace with your actual URL from API*/
        title="Aurae Health"
        allow="camera; microphone; autoplay; clipboard-read; clipboard-write; fullscreen"
        allowFullScreen
        /* Adjust the style as needed */
        style={{
  width: '100%',
  height: '100%',
  border: 'none',
  paddingTop: '10px',
  marginBottom: '10px',
  boxSizing: 'border-box',
}}
      />

    </div>
  );
};

export default IframeWithPermissions;
