import { PageHeader } from "antd";
import React from "react";

// displays a page header

export default function Header() {
  return (
    <a href="https://github.com/le-dawg/reefi-jelly" target="_blank" rel="noopener noreferrer">
      <PageHeader title="🌊 Reefi-Jelly " subTitle="🪸 The Coral Saving ReFi DAO" style={{ cursor: "pointer" }} />
    </a>
  );
}
