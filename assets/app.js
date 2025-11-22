// Soft loading overlay and element entrance orchestrator
(function(){
  function createLoading(){
    const existing = document.getElementById('global-loading');
    if(existing) return existing;
    const wrap = document.createElement('div'); wrap.id='global-loading';
    const logo = document.createElement('div'); logo.className='logo';
    // try to use site favicon/logo if present
    const favicon = document.querySelector('link[rel~="icon"]');
    if(favicon && favicon.href) logo.style.backgroundImage = `url(${favicon.href})`;
    const spinner = document.createElement('div'); spinner.className='spinner';
    wrap.appendChild(logo); wrap.appendChild(spinner);
    document.body.appendChild(wrap);
    return wrap;
  }

  // show loading while page initializes
  document.documentElement.classList.add('preload');
  const loader = createLoading();

  function finishLoading(){
    try{
      loader.classList.add('hide');
      setTimeout(()=>{ if(loader && loader.parentNode) loader.parentNode.removeChild(loader); },500);
      document.documentElement.classList.remove('preload');
      document.documentElement.classList.add('loaded');
      // reveal elements with data-animate with a small stagger
      const els = Array.from(document.querySelectorAll('[data-animate]'));
      els.forEach((el,i)=>{
        const delay = (parseFloat(el.getAttribute('data-delay')) || (i*80))/1000;
        setTimeout(()=>{ el.classList.add('in-view'); el.classList.remove('animate'); if(el.classList.contains('reveal-img')) el.classList.add('visible'); }, delay*1000);
      });
    }catch(e){console.warn(e)}
  }

  // Wait for DOMContentLoaded and a short minimum time to ensure soft UX
  const minMs = 450;
  const start = Date.now();
  window.addEventListener('DOMContentLoaded', function(){
    const left = Math.max(0, minMs - (Date.now()-start));
    setTimeout(finishLoading, left + 250);
  });

  // If page already loaded, still respect a small delay
  if(document.readyState === 'complete' || document.readyState === 'interactive'){
    setTimeout(finishLoading, 600);
  }
})();

// Auto-add animate class to elements we want to animate
(function(){
  document.addEventListener('DOMContentLoaded', function(){
    try{
      const auto = document.querySelectorAll('[data-animate]');
      auto.forEach(el=>el.classList.add('animate'));
    }catch(e){}
  });
})();

// Confetti utility: creates colorful pieces and removes them after `duration` ms
(function(){
  function makePiece(color){
    const el = document.createElement('div');
    el.className = 'confetti-piece';
    el.style.background = color;
    el.style.left = (10 + Math.random()*80) + 'vw';
    el.style.transform = 'rotate('+(Math.random()*360)+'deg)';
    el.style.width = (8 + Math.random()*10) + 'px';
    el.style.height = (12 + Math.random()*12) + 'px';
    el.style.opacity = (0.85 + Math.random()*0.15);
    return el;
  }

  function runConfetti(duration){
    const colors = ['#FF7A90','#7DE2B8','#FFD06B','#9AD3FF','#C8A2FF','#FFC4E1','#FFE7A7'];
    const root = document.createElement('div');
    root.className = 'confetti-root';
    root.style.position = 'fixed';
    root.style.inset = '0';
    root.style.pointerEvents = 'none';
    root.style.zIndex = 5000;
    document.body.appendChild(root);

    const pieces = 40;
    for(let i=0;i<pieces;i++){
      const p = makePiece(colors[Math.floor(Math.random()*colors.length)]);
      // randomize animation timing
      p.style.left = (Math.random()*100) + 'vw';
      p.style.top = (-10 - Math.random()*20) + 'vh';
      p.style.transition = 'transform 1.8s cubic-bezier(.2,.8,.2,1), top 1.8s linear, opacity 1.8s linear';
      root.appendChild(p);
      // animate drop with slight delay
      setTimeout(()=>{
        p.style.top = (60 + Math.random()*40) + 'vh';
        p.style.transform = 'rotate('+(360+Math.random()*720)+'deg) translateY(0)';
        p.style.opacity = '0';
      }, 30 + Math.random()*300);
    }

    return new Promise(resolve=>{
      setTimeout(()=>{
        try{ if(root && root.parentNode) root.parentNode.removeChild(root); }catch(e){}
        resolve();
      }, duration || 1600);
    });
  }

  // expose globally
  window.runConfetti = runConfetti;
})();
