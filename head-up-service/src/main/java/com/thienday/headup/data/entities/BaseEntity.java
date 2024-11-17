package com.thienday.headup.data.entities;



import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.util.Date;

@MappedSuperclass
@Getter
@Setter
@EntityListeners(AuditingEntityListener.class)
public class BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private long id;

    @Column(name = "updated_by")
    private String updatedBy;

    @Column(name = "updated_time")
    @UpdateTimestamp
    private Date updatedTime;

    @Column(name = "created_by")
    private String createdBy;

    @Column(name = "created_time")
    @CreationTimestamp
    private Date createdTime;

    @Column(name = "is_deleted")
    private Boolean isDeleted = false;
}
